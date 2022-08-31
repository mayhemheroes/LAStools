FROM fuzzers/afl:2.52

RUN apt-get update
RUN apt install -y build-essential wget git clang cmake  automake autotools-dev  libtool zlib1g zlib1g-dev libexif-dev \
    libjpeg-dev 
RUN git clone https://github.com/LAStools/LAStools.git
WORKDIR /LAStools	
RUN cmake -DCMAKE_C_COMPILER=afl-gcc -DCMAKE_CXX_COMPILER=afl-g++ .
RUN make
RUN make install
RUN mkdir /lazCorpus
RUN cp ./data/house.laz /lazCorpus
RUN cp ./data/test.laz /lazCorpus
RUN cp ./data/sample.laz /lazCorpus
RUN cp ./data/lake.laz /lazCorpus
RUN cp ./data/TO_core_last_zoom.laz /lazCorpus
#RUN cp ./data/*.laz /lazCorpus
#RUN rm -f /lazCorpus/fusa.laz
#RUN rm -f /lazCorpus/zurich.laz


ENTRYPOINT ["afl-fuzz", "-i", "/lazCorpus", "-o", "/las2txtOut"]
CMD ["/LAStools/bin64/lasinfo64", "@@"]
