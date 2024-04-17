package com.example.ani_life

import android.app.Application

import com.yandex.mapkit.MapKitFactory

class MainApplication: Application() {
    override fun onCreate() {
        super.onCreate()
        MapKitFactory.setLocale("YOUR_LOCALE") // Your preferred language. Not required, defaults to system language
        MapKitFactory.setApiKey("6f1595ea-afa4-4d01-b8e0-1f7bff60e0ba") // Your generated API key
    }
}