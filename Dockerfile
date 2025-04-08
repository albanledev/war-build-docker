# Utiliser l'image Maven pour builder l'application
FROM maven:3.8.4-jdk-11 AS build

# Copier le projet local dans le conteneur
COPY . /app

# Définir le répertoire de travail dans le conteneur
WORKDIR /app

# Builder l'application et générer le fichier .war
RUN mvn clean package -DskipTests

# Utiliser l'image de Tomcat comme base pour déployer l'application
FROM tomcat:9.0

# Copier le fichier .war généré depuis l'étape précédente
COPY --from=build /app/target/mon-app.war /usr/local/tomcat/webapps/

# Exposer le port pour accéder à l'application
EXPOSE 8080