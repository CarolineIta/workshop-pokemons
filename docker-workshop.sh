#!/usr/bin/env bash
browser="headless-chrome"

#Cria a pasta onde vão ficar os resultados dos testes ou apaga os resultados existentes

mkdir build
mkdir build/erros
mkdir build/reports
rm -rf build/erros/*
rm -rf build/reports/*

#Se existir um container com o nome de work_tests ele é pausado e em seguida apagado
sudo docker stop $(sudo docker ps -aq -f "name=work_tests") || true && sudo docker rm $(sudo docker ps -aq -f "name=work_tests") || true

# coloca a caminho do volume que vai ser espelhado para a pasta atual 
features_to_run="$(pwd)/"

index=0


# Executa os arquivos dentro da pasta features atrasves do arquivo cucumber-comand-parallel.sh
sudo docker run -d -e rerun_index=${index} -e browser=${browser} \
-v ${features_to_run}/:/app/ \
--name work_tests1 workshop

run_exit_code=sudo docker wait $(sudo docker ps -q -f "name=work_tests")

#Copia os logs e arquivos de saida do teste para o volume no host

sudo docker logs work_tests1 >> build/reports/build_logs.txt
    

exit $run_exit_code

