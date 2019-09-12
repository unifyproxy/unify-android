package com.unifyproxy.unify.services

import android.annotation.TargetApi
import android.content.Intent
import android.net.VpnService;
import android.os.Build
import android.os.ParcelFileDescriptor

@TargetApi(Build.VERSION_CODES.M)
class UnifyVpnService: VpnService(){
    val builder by lazy {
        Builder()
    }

    lateinit var localTunnel: ParcelFileDescriptor;

    fun initLocalTun(address: String, prefix_length: Int) {
        val prepared = VpnService.prepare(this)

        if(prepared != null) {
            return
        }

        localTunnel = builder.addAddress(address, prefix_length).establish()
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {

        if(intent != null) {
            val network = intent.getBundleExtra("network")
            val address = network.getString("address")
            val prefix_length = network.getInt(("prefix_length"))
            initLocalTun(address!!, prefix_length)
        }
        return super.onStartCommand(intent, flags, startId)
    }
}