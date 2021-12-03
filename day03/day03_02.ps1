$data = Get-Content -Path "$($PSScriptRoot)/input.txt"
$bitcount = $data[0].Length

$i = 0
while($elements1 -is [array] -and $elements1.Length -gt 1 -and $i -lt $bitcount) {
    $ones = $elements1 | Where-Object { $_[$i] -eq '1'}
    $zeroes = $elements1 | Where-Object { $_[$i] -eq '0'}
    $ones_length = $ones.Length
    if ($ones -is [string]) {
        $ones_length = 1
    }

    if ($ones_length -ge $elements1.Length/2) {
        $elements1 = $ones
    } elseif ($ones_length -eq $elements1.Length/2) {
        $elements1 = $ones
    } else {
        $elements1 = $zeroes
    }
    
    $i++
}

$i = 0
while($elements0 -is [array] -and $elements0.Length -gt 1 -and $i -lt $bitcount) {
    $ones = $elements0 | Where-Object { $_[$i] -eq '1'}
    $zeroes = $elements0 | Where-Object { $_[$i] -eq '0'}
    $zeroes_length = $zeroes.Length
    if ($zeroes -is [string]) {
        $zeroes_length = 1
    }

    if ($zeroes_length -lt $elements0.Length/2) {
        $elements0 = $zeroes
    } elseif ($zeroes_length -eq $elements0.Length/2) {
        $elements0 = $zeroes
    } else {
        $elements0 = $ones
    }
    
    $i++
}

$e0 = [Convert]::ToInt32($elements0,2)
$e1 = [Convert]::ToInt32($elements1,2)
$e0*$e1