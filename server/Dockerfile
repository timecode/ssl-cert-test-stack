FROM nginx

###############################################################################
#                                UPDATE OS
###############################################################################

RUN apt-get update -qq \
 && apt-get upgrade -qq \
 && apt-get install -dqq \
      ca-certificates \
      vim \
 && apt-get autoremove -qq \
 && apt-get clean -qq

###############################################################################
#                                    START
###############################################################################

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
CMD [ "/entrypoint.sh" ]
