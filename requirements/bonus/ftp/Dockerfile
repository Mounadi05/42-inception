FROM debian:buster
 
RUN apt-get update && apt-get install -y vsftpd

COPY /tools/vsftpd.conf /etc/vsftpd.conf

COPY /tools/script.sh /root/

RUN chmod +x /root/script.sh

EXPOSE 21

CMD ["/root/script.sh"]

