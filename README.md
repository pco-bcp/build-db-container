# Database Image Builder

This is a very simple process which will creaete a mariadb image with a pre-populated database. It is based on work
from https://github.com/lindycoder/prepopulated-mysql-container-example


## How it works

All you need to do is place an sql file in the same directory as this project and run the docker build command.
It will build a container and automatically load your database so that when it is run as a container, you have
a mysql server with a pre-loaded database.

It does this by copying your sql file into `/docker-entrypoint-initdb.d/`. Anything in that folder will be executed
when the server starts.

## How to use it

First copy your sql file into this directory (the actual root directory of this repo). It can have any name but
must end with a .sql suffix.

Then run the build command similar to the example below.
This command will build an image with the given name and tag it as `latest` and leave it in your local registry.

`docker build --tag ghcr.io/pco-bcp/ici-database .`

It's good to have the image tagged as both 'latest' and the date of the image. So let's add a date tag now.
Use this command, with the current date:

`docker tag ghcr.io/pco-bcp/ici-database:latest ghcr.io/impact-canada/ici-database:2023-04-26`

Next you push both images up to the container registry (it's actually the same image with two tags).
In this example we will use the GitHub Container Registry
at ghcr.io. You need to log in first using your PAT (personal access token).:

`echo "your-token" | docker login ghcr.io -u USERNAME --password-stdin`

Now push them up:

`docker push ghcr.io/pco-bcpa/ici-database:latest`<br>
`docker push ghcr.io/pco-bcp/ici-database:2023-04-16`<br>
or<br>
`docker push ghcr.io/pco-bcp/pm-database:latest`<br>
`docker push ghcr.io/pco-bcp/pm-database:2023-04-26`

## To view your GitHub Container Registry

To view your container registry, go to your organization page in github.com and click on the Packages link in the main menu.

## How to delete a package or version

- Search for and select your package.

- To delete the entire package, click the **Package settings** button on the right and find the delete option.

- To delete a specific version, click the **View and manage all versions** link, and from there you can delete a specific version.
