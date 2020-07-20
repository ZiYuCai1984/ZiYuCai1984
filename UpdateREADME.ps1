Set-Location -Path $PSScriptRoot

if($env:CI)
{
    git submodule update --remote
}

$Documents= Get-ChildItem -Path ".\ZiYuCai1984.github.io\_posts" | Get-ItemPropertyValue -Name 'Name'
[Array]::Reverse($Documents)
$Documents=$Documents[0..5]


for ($i=0;$i -le ($Documents.length - 1);++$i)
{
    $d=$Documents[$i];
    $t= $d -split "-",4
    
    $title=$t[3].Remove($t[3].Length-3,3)
    $pushTime=$d.Replace("-"+$t[3],"")

    $link="https://ziyucai1984.github.io/"+$pushTime.Replace("-","/")+"/$title"
    $line="- [$title ($pushTime)]($link)`n"
    $Documents[$i]=$line
}

$Documents =$Documents | Out-String

$Readme="## About me 🚩

- .net development engineer,foucsing on wpf 🎨

- Development of medical software 💊

- Work in Shanghai, China ☂️

- Contact me via yucaizi1984@gmail.com 📧

- This is my blog [ziyucai1984.github.io](https://ziyucai1984.github.io/) 🐌

## Recent articles ✍🏽

$Documents

## Update regularly via action 🚀

| Build time | Build status   |
| ------------ | ------------ |
| $(get-date -format yyyy-MM-dd-HH-mm-ss)(UTC)  |   ![Auto Push](https://github.com/ZiYuCai1984/ZiYuCai1984/workflows/Auto%20Push/badge.svg) |

"

Write-Output $Readme > .\README.md





if($env:CI)
{
    git config --global user.email "yucaizi1984@gmail.com"
    git config --global user.name "ZiYuCai_Automation"
    git add .
    git commit -m "$env:COMMIT_MESSAGE"
    git push --set-upstream https://$env:TOKEN_AUTO_PUSH@github.com/ZiYuCai1984/ZiYuCai1984 master
}