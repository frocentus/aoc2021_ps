$data = Get-Content -Path "$($PSScriptRoot)/input.txt"
$result = 0
$previous = [int]::MaxValue
for($i=0;$i -lt $data.Length-2; $i++) {
    $sum = ([int]$data[$i],[int]$data[$i+1],[int]$data[$i+2])  | Measure-Object -Sum
    if ($sum.Sum -gt $previous) {
        $result++
    }
    $previous = $sum.Sum
}
$result