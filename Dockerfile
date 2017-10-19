FROM ubuntu:17.04

# ------------------------------------------------------
# --- Install required tools
# Dependencies to execute Android builds
#RUN dpkg --add-architecture i386
#RUN apt-get update -qq
#RUN DEBIAN_FRONTEND=noninteractive apt-get install -y openjdk-8-jdk libc6:i386 libstdc++6:i386 libgcc1:i386 libncurses5:i386 libz1:i386
RUN apt-get update -qq \
    && apt-get install -y openjdk-8-jdk wget expect git curl unzip vim \
    && apt-get clean

# ------------------------------------------------------
# --- Download Android SDK tools into $ANDROID_SDK_HOME

RUN groupadd android && useradd -d /opt/android-sdk-linux -g android android

COPY tools /opt/tools

COPY licenses /opt/licenses

WORKDIR /opt/android-sdk-linux

RUN chown android:android /opt/android-sdk-linux

USER android

RUN /opt/tools/android-sdk-update.sh built-in

USER root

CMD /opt/tools/entrypoint.sh built-in

