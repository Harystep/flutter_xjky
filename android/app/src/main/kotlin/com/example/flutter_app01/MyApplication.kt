package com.example.flutter_app01

import android.app.Activity
import android.app.Application


class MyApplication : Application() {

    companion object {
        private var currentActivity: Activity? = null
        @JvmStatic
        fun getCurrentActivity(): Activity? {
            return currentActivity
        }

        fun setCurrentActivity(activity: Activity) {
           this.currentActivity = activity
        }
    }



}