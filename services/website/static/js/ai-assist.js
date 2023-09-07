let mediaRecorder;
let audioChunks = [];

// functions
function sendAudioData(audioData) {
    console.log("Size of audio blob:", audioData.size);  // This should be greater than 0.
    const formData = new FormData();
    formData.append('audio', audioData);

    fetch('/record', {
        method: 'POST',
        body: formData
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
        document.getElementById('status').textContent = 'Recording saved!';
    })
    .catch(error => {
        console.error("There was a problem with the fetch operation:", error);
    });
}

function playRecordedAudio() {
    // const audio = new Audio('/audio');
    // audio.play();
    fetch('/audio')
        .then(response => response.blob())
        .then(blob => {
            var audio = new Audio(URL.createObjectURL(blob));
            audio.play();
        })
}

// content
document.getElementById('record').addEventListener('click', function() {
    // update text box
    document.getElementById('status').textContent = 'Recording in progress...';
    // start recording
    navigator.mediaDevices.getUserMedia({ audio: true })
        .then(stream => {
            mediaRecorder = new MediaRecorder(stream);
            audioChunks = [];
            
            mediaRecorder.ondataavailable = event => {
                audioChunks.push(event.data);
            };

            mediaRecorder.onstop = () => {
                console.log("Number of audio chunks:", audioChunks.length); // Check this
                const audioData = new Blob(audioChunks, { type: 'audio/wav' });
                sendAudioData(audioData);
            };
            
            mediaRecorder.start();
            document.getElementById('status').textContent = 'Recording in progress...';
        })
        .catch(error => {
            console.error("Error accessing microphone:", error);
        });
});

document.getElementById('translate').addEventListener('click', function() {
    document.getElementById('status').textContent = 'Processing your request...';
    fetch('/translate_hf')
        .then(response => response.json())
        .then(data => {
            document.getElementById('status').textContent = data.text;
            // playRecordedAudio();
        });
});

// TODO doesn't stop playback
document.getElementById('stop').addEventListener('click', function() {
    if (mediaRecorder && mediaRecorder.state === 'recording') {
        mediaRecorder.stop();
    }
    document.getElementById('status').textContent = '';
});