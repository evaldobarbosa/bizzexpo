# Healthcheck


## API

O healthcheck do container da api deve ser o seguinte:

- o docker-compose é rodado;
- o healthchecker do container é rodado buscando o 200 da rota de healthcheck da aplicação;
- uma consulta ao status do container (healthy) é executada 30 segundos depois de o container ser iniciado;
- uma nova consulta é feita a cada 10 segundos;
	- unhealthy retorna uma mensagem de retentativa;
- ao conseguir 'healthy' do container, então o ciclo se fecha e o step de deploy da pipeline finaliza.