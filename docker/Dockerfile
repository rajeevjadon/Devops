FROM ubuntu:24.04  
WORKDIR /testapp  
RUN apt update -y   
RUN apt install nginx -y          
RUN echo "Hello Devops INsider"   >  /var/www/html/index.html  
CMD [ "nginx", "-g", "daemon off;" ] 

# WORKDIR /testapp  
# RUN apt update -y  
# RUN apt install nginx -y 
# RUN echo "Hello Devops Insiders"  > /var/www/html/index.html
# CMD ["nginx", "-g", "daemon off;"]

