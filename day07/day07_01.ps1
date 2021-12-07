$data = Get-Content -Path "$($PSScriptRoot)/input.txt"
$crabs = ($data -split ',').ForEach({ [int]$_ })
$measure = $crabs | Measure-Object -Maximum -Minimum

$optimum = [Int]::MaxValue

for($i=$measure.Minimum; $i -le $measure.Maximum; $i++) {
    $sum = 0
    $crabs.ForEach({
        $sum += [Math]::Abs($_ - $i)
    })
    if ($sum -lt $optimum) {
        $optimum = $sum
    }
}
$optimum