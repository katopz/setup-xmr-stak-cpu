ssh $SSH "git clone https://github.com/fireice-uk/xmr-stak-cpu.git
cd xmr-stak-cpu
sudo add-apt-repository ppa:ubuntu-toolchain-r/test
sudo apt update -y
sudo apt install -y gcc-5 g++-5 make
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-5 1 --slave /usr/bin/g++ g++ /usr/bin/g++-5
curl -L http://www.cmake.org/files/v3.4/cmake-3.4.1.tar.gz | tar -xvzf - -C /tmp/
cd /tmp/cmake-3.4.1/ && ./configure && make && sudo make install && cd -
sudo update-alternatives --install /usr/bin/cmake cmake /usr/local/bin/cmake 1 --force
sudo apt install -y libmicrohttpd-dev libssl-dev libhwloc-dev
cmake .
make install"

# Config 
# "cpu_threads_conf" : [
#     { "low_power_mode" : true, "no_prefetch" : true, "affine_to_cpu" : 0 },
# ],
# "wallet_address" : "42cr4zNKdqPWkCUntq28rRXn9tcXUQJ9xbECb69gEuPjYDLVb2jJrYCEfEDiEJwP8LUYr2Fm6pwMtHH9hXQrKh7wRSYzUrc",
# "daemon_mode" : true,
# "httpd_port" : 80,
ssh $SSH "nano ./xmr-stak-cpu/bin/config.txt"

# Run
ssh $SSH "./xmr-stak-cpu/bin/xmr-stak-cpu & disown && exit"

# Cron
ssh $SSH "echo \"@reboot ~/xmr-stak-cpu/bin/xmr-stak-cpu & disown\" | tee -a /var/spool/cron/root"
