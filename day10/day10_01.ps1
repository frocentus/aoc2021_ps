$data = Get-Content -Path "$($PSScriptRoot)/input.txt"

$scores = @{
    ')' = 3
    ']' = 57
    '}' = 1197
    '>' = 25137
}

$illegal = @()

foreach ($line in $data) {

    $stack = [System.Collections.Stack]::new()
    Write-Host "`n> :" -NoNewline
    :nextline foreach ($char in $line.ToCharArray()) {
        Write-Host "$char" -NoNewline
        switch ($char) {
            ')' { 
                if ($stack.Peek() -eq '(') {
                    $null = $stack.Pop()
                }
                else {
                    $illegal += $char
                    break nextline
                } 
            }
            ']' {
                if ($stack.Peek() -eq '[') {
                    $null = $stack.Pop()
                }
                else {
                    $illegal += $char
                    break nextline
                } 
            }
            '}' { 
                if ($stack.Peek() -eq '{') {
                    $null = $stack.Pop()
                }
                else {
                    $illegal += $char
                    break nextline
                } 
            }
            '>' {  
                if ($stack.Peek() -eq '<') {
                    $null = $stack.Pop()
                }
                else {
                    $illegal += $char
                    break nextline
                } 
            }
            Default { $stack.Push($char) }
        }
        
    }
    
}
Write-Host "`n"

$result = 0
foreach($brace in $illegal) {
     $result += $scores."$brace"
}
Write-Host "$illegal : $result"