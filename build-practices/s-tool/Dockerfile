FROM bash
WORKDIR /s-tool
COPY readme .
COPY src.sh .
RUN ln -s /s-tool/src.sh /etc/profile.d/s-tool.sh
ENTRYPOINT ["bash", "/s-tool/src.sh"]
CMD ["declare","-F"]
