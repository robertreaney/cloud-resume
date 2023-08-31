$sshKeyPath = "$env:USERPROFILE\.ssh\id_rsa"
$remoteHost = "52.54.162.179"
$remoteUser = "ubuntu"
$remoteScript = @'
date +"%Y-%m-%d %H:%M:%S" > ~/refresh-proof.log
cd cloud-resume
git pull
docker compose down
docker compose up --build
'@

$sshArgs = @(
    "-i", $sshKeyPath,
    "$remoteUser@$remoteHost",
    "-o", "StrictHostKeyChecking=no",
    "bash -s"
)

$remoteScript | ssh $sshArgs