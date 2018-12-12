# Atribui o diretorio atual na variavel 
$folder = Get-location

# Verifica se a pasta build existe e retorna True ou False
$build_folder = test-path -path $folder\build 

if ($build_folder -eq $false){
    mkdir build
    mkdir build/erros
    mkdir build/reports
}else{
    Remove-item  $folder\build\reports\*
    Remove-item  $folder\build\erros\*
}

# Verifica se tem algum container que contenha no nome work_tests e pausa os mesmos
docker stop $(docker ps -qa -f "name=work_tests")

# Verifica se tem algum container que contenha no nome work_tests e remove os mesmos
docker rm $(docker ps -aq -f "name=work_tests")

# Coloca a caminho do volume que vai ser espelhado para a pasta atual 
# Executa os arquivos dentro da pasta features atrasves do arquivo cucumber-comand.sh
docker run -d -e rerun_index=0 -e browser="headless-chrome" -v $folder/:/app/ --name work_tests1 workshop

# Aduarda o termino da criação do container 
docker wait $( docker ps -q -f "name=work_tests")

#Copia os logs e arquivos de saida do folder para o volume no host
docker logs work_tests1 >> build/reports/build_logs.txt

