cmake_minimum_required(VERSION 3.4.0)

add_library(libancillary STATIC
        libancillary/fd_recv.c
        libancillary/fd_send.c
        )

target_include_directories(libancillary PUBLIC
        libancillary/
        )



add_executable(tun2socks
            badvpn/base/BLog_syslog.c
            badvpn/system/BReactor_badvpn.c
            badvpn/system/BSignal.c
            badvpn/system/BConnection_common.c
            badvpn/system/BConnection_unix.c
            badvpn/system/BTime.c
            badvpn/system/BUnixSignal.c
            badvpn/system/BNetwork.c
            badvpn/flow/StreamRecvInterface.c
            badvpn/flow/PacketRecvInterface.c
            badvpn/flow/PacketPassInterface.c
            badvpn/flow/StreamPassInterface.c
            badvpn/flow/SinglePacketBuffer.c
            badvpn/flow/BufferWriter.c
            badvpn/flow/PacketBuffer.c
            badvpn/flow/PacketStreamSender.c
            badvpn/flow/PacketPassConnector.c
            badvpn/flow/PacketProtoFlow.c
            badvpn/flow/PacketPassFairQueue.c
            badvpn/flow/PacketProtoEncoder.c
            badvpn/flow/PacketProtoDecoder.c
            badvpn/socksclient/BSocksClient.c
            badvpn/tuntap/BTap.c
            badvpn/lwip/src/core/udp.c
            badvpn/lwip/src/core/memp.c
            badvpn/lwip/src/core/init.c
            badvpn/lwip/src/core/pbuf.c
            badvpn/lwip/src/core/tcp.c
            badvpn/lwip/src/core/tcp_out.c
            badvpn/lwip/src/core/netif.c
            badvpn/lwip/src/core/def.c
            badvpn/lwip/src/core/ip.c
            badvpn/lwip/src/core/mem.c
            badvpn/lwip/src/core/tcp_in.c
            badvpn/lwip/src/core/stats.c
            badvpn/lwip/src/core/inet_chksum.c
            badvpn/lwip/src/core/timeouts.c
            badvpn/lwip/src/core/ipv4/icmp.c
            badvpn/lwip/src/core/ipv4/igmp.c
            badvpn/lwip/src/core/ipv4/ip4_addr.c
            badvpn/lwip/src/core/ipv4/ip4_frag.c
            badvpn/lwip/src/core/ipv4/ip4.c
            badvpn/lwip/src/core/ipv4/autoip.c
            badvpn/lwip/src/core/ipv6/ethip6.c
            badvpn/lwip/src/core/ipv6/inet6.c
            badvpn/lwip/src/core/ipv6/ip6_addr.c
            badvpn/lwip/src/core/ipv6/mld6.c
            badvpn/lwip/src/core/ipv6/dhcp6.c
            badvpn/lwip/src/core/ipv6/icmp6.c
            badvpn/lwip/src/core/ipv6/ip6.c
            badvpn/lwip/src/core/ipv6/ip6_frag.c
            badvpn/lwip/src/core/ipv6/nd6.c
            badvpn/lwip/custom/sys.c
            badvpn/tun2socks/tun2socks.c
            badvpn/base/DebugObject.c
            badvpn/base/BLog.c
            badvpn/base/BPending.c
            badvpn/system/BDatagram_unix.c
            badvpn/flowextra/PacketPassInactivityMonitor.c
            badvpn/tun2socks/SocksUdpGwClient.c
            badvpn/udpgw_client/UdpGwClient.c
        )

target_include_directories(tun2socks PUBLIC
        libancillary
        badvpn/lwip/src/include/ipv4
        badvpn/lwip/src/include/ipv6
        badvpn/lwip/src/include
        badvpn/lwip/custom
        badvpn
        )


target_compile_definitions(tun2socks PUBLIC
        "std=gnu99"
        -DBADVPN_THREADWORK_USE_PTHREAD -DBADVPN_LINUX -DBADVPN_BREACTOR_BADVPN -D_GNU_SOURCE
        -DBADVPN_USE_SIGNALFD -DBADVPN_USE_EPOLL
        -DBADVPN_LITTLE_ENDIAN -DBADVPN_THREAD_SAFE
        -DNDEBUG -DANDROID
        )

find_library(ng-log log)


target_link_libraries(tun2socks libancillary ${ng-log})
