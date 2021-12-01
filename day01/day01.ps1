$data = Get-Content -Path "$($PSScriptRoot)/input.txt"
$result = 0
$previous = [int]::MaxValue
foreach($d in $data) {
    $i = [int]$d
    if ($i -gt $previous) {
        $result++
    } 
    $previous = $i
}
$result