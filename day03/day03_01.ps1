$data = Get-Content -Path "$($PSScriptRoot)/input.txt"
$length = $data.Length
$ones = [int[]]::new($data[0].Length)
foreach($d in $data) {
    for($i=0; $i -lt $ones.Length; $i++) {
        if ($d[$i] -eq '1') {
            $ones[$i] += 1
        }
    }
}

$epsilon = [int[]]::new($data[0].Length)
$gamma = [int[]]::new($data[0].Length)

for($i=0; $i -lt $ones.Length; $i++) {
    if($ones[$i] -lt $length/2) {
        $epsilon[$i] = 1
    } else {
        $gamma[$i] = 1
    }
}

$e = [Convert]::ToInt32("$($epsilon -join '')",2)
$g = [Convert]::ToInt32("$($gamma -join '')",2)
$e*$g

