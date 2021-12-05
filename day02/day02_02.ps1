$data = Get-Content -Path "$($PSScriptRoot)/input.txt"
$horizontal = $vertical = $aim = 0
$data.ForEach({
    $parts = $_ -split ' '
    $value = [int]$parts[1]
    switch ($parts[0].Length) {
        7 { 
            $horizontal += $value 
            $vertical += ($aim * $value )
        }
        4 { $aim += $value  }
        2 { $aim -= $value  }
    }
})
$horizontal * $vertical