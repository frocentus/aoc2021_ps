$data = Get-Content -Path "$($PSScriptRoot)/input.txt"
$crabs = ($data -split ',').ForEach({ [int]$_ })
$measure = $crabs | Measure-Object -Maximum -Minimum

$optimum = [Int]::MaxValue

for($i=$measure.Minimum; $i -le $measure.Maximum; $i++) {
    $distances = 0
    $crabs.ForEach({
        $steps = [Math]::Abs($_ - $i)
        $value = ($steps * ($steps+1)) / 2
        $distances += $value
    })

    if ($distances -lt $optimum) {
        $optimum = $distances
    }
}
$optimum