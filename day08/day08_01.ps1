$data = Get-Content -Path "$($PSScriptRoot)/input.txt"

$count = 0
$data.ForEach({
    $line = $_.Split('|')
    "$($line[0]) = $($line[1])"
    $numbers = $line[1].Split(' ')

    $numbers.ForEach({
        $segments = $_
        switch ( $segments.Length ) {
            2 { 
                # 1
                $count++
            }
            3 {
                # 7
                $count++
            }
            4 {
                # 4
                $count++
            }
            7 {
                # 8
                $count++
            }
            Default {

            }
        }
    })

})

$count