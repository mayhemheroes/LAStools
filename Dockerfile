FROM fuzzers/afl:2.52 as builder

RUN apt-get update
RUN apt install -y build-essential wget git clang cmake  automake autotools-dev  libtool zlib1g zlib1g-dev libexif-dev \
    libjpeg-dev 
RUN git clone https://github.com/LAStools/LAStools.git
WORKDIR /LAStools	
RUN cmake -DCMAKE_C_COMPILER=afl-gcc -DCMAKE_CXX_COMPILER=afl-g++ .
RUN make
RUN make install

FROM fuzzers/afl:2.52
COPY --from=builder /LAStools/bin64/lasinfo64 /
COPY --from=builder /LAStools/data/*.laz /testsuite/

ENTRYPOINT ["afl-fuzz", "-i", "/testsuite", "-o", "/las2txtOut"]
CMD ["/lasinfo64", "@@"]
