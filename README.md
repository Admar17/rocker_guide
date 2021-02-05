# rocker_guide

### Adding rocker container to n451:

1. Go to your command line and run the following to pull the existing tidyverse image from [docker hub](https://hub.docker.com/r/rocker/tidyverse): 

```
docker pull rocker/tidyverse
```
2. Copy the snippet below and paste it at the bottom of your existing docker-compose.yml file. If using VS Code, you may have to install the docker-compose.yml extension. The spacing and what not needs to be exactly right because it is a YAML file.

```yml
rocker:
    image: rocker/tidyverse
    environment: 
      - DISABLE_AUTH=true
    depends_on: 
      - db
    ports: 
      - '8787:8787'
    volumes:
      - ./scripts:/home/rstudio/scripts
      - ./scratch:/home/rstudio/scratch
      - ./work:/home/rstudio/work
      - ./data:/home/rstudio/data
    networks: 
      - n451
```
(Will explain the above stuff later)


3. Run the following command in your terminal with your project directory as the working directory: 

```
docker-compose up
```

4. Either enter http://localhost:8787/ in the browser or go to your Docker Desktop app and open in the browser from there.

![](images/docker_screenshot.PNG)
