## MyToast   



```Java
package com.vma.code.logic.activity;

import android.Manifest;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.net.Uri;
import android.os.Build;
import android.provider.Settings;
import android.text.TextUtils;
import android.util.Log;
import android.view.View;

import androidx.annotation.NonNull;
import androidx.core.app.ActivityCompat;

import com.vma.code.common.BaseRxActivity;
import com.vma.code.common.Config;
import com.vma.code.common.bean.CheckPointBean;
import com.vma.code.common.bean.LoginRspBean;
import com.vma.code.common.tools.MyToast;
import com.vma.code.common.tools.TimeTool;
import com.vma.code.logic.R;
import com.vma.code.logic.mvp.presenter.MainPresenter;
import com.vma.code.logic.mvp.view.IMainView;

import java.io.Serializable;
import java.util.List;

import butterknife.ButterKnife;
import butterknife.OnClick;

/**
 * <pre>
 *     author : wt
 *     time   : 2020/10/21
 *     desc   :
 *     version: 1.0
 * </pre>
 */
public class MainActivity extends BaseRxActivity<MainPresenter> implements IMainView {
    int REQUEST_CODE_WRITE_SETTINGS = 1003;
    private final static int RC_PERMISSION = 10;

    @Override
    protected boolean isHideStatusBar() {
        return false;
    }

    @Override
    protected void onBindMainLayoutId() {
        setContentView(R.layout.activity_main);
        ButterKnife.bind(this);
    }

    @Override
    protected void onInitView() {
        setPresenter(new MainPresenter(this));
    }

    @Override
    protected void onLoadData() {

    }

    @Override
    protected void onYourThings() {
        checkPermission();
    }

    @OnClick({R.id.ivBack,R.id.cvCourse, R.id.ivSetting, R.id.ivGallery, R.id.ivExpand,R .id.ivParentCenter})
    public void onClick(View view) {
        if(TimeTool.isFastClick()){
            return;
        }
        switch (view.getId()) {
            case R.id.ivBack:
                finish();
                break;
            case R.id.cvCourse:
                if(TextUtils.isEmpty(Config.publicUserId)){
                    showLoadingCheckReturn();
                    mPresenter.getUserInfo(1);
                    return;
                }
                startActivity(new Intent(this, CourseActivity.class));
                break;
            case R.id.ivSetting:
                requestWriteSettings();
//                SettingDialog settingDialog = new SettingDialog(getThisActivity());
//                settingDialog.show();
                break;
            case R.id.ivGallery:
                
                break;
            case R.id.ivExpand:
                
                break;
            case R.id.ivParentCenter:
//                ParentCenterDialog parentCenterDialog = new ParentCenterDialog(getThisActivity());
//                parentCenterDialog.show();
                break;
        }
    }

    /**
     * 申请权限
     */
    private void requestWriteSettings() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            //大于等于23 请求权限
            if (!Settings.System.canWrite(getApplicationContext())) {
                Intent intent = new Intent(Settings.ACTION_MANAGE_WRITE_SETTINGS);
                intent.setData(Uri.parse("package:" + getPackageName()));
                startActivityForResult(intent, REQUEST_CODE_WRITE_SETTINGS);
            }
        }
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode == REQUEST_CODE_WRITE_SETTINGS) {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                //Settings.System.canWrite方法检测授权结果
                if (!Settings.System.canWrite(getApplicationContext())) {
                    MyToast.showMessage(getThisActivity(), "您拒绝了权限,将无法调整亮度");
                }
            }
        }
    }

    private void checkPermission(){
        if (!(ActivityCompat.checkSelfPermission(getThisActivity(), Manifest.permission.WRITE_EXTERNAL_STORAGE) == PackageManager.PERMISSION_GRANTED)
                ||!(ActivityCompat.checkSelfPermission(getThisActivity(), Manifest.permission.CAMERA) == PackageManager.PERMISSION_GRANTED)
                ||!(ActivityCompat.checkSelfPermission(getThisActivity(), Manifest.permission.ACCESS_FINE_LOCATION) == PackageManager.PERMISSION_GRANTED)
                ||!(ActivityCompat.checkSelfPermission(getThisActivity(), Manifest.permission.RECORD_AUDIO) == PackageManager.PERMISSION_GRANTED)){
            //没有权限，申请权限
            String[] permissions = {Manifest.permission.WRITE_EXTERNAL_STORAGE,Manifest.permission.CAMERA,Manifest.permission.ACCESS_FINE_LOCATION,Manifest.permission.RECORD_AUDIO};
            //申请权限，其中RC_PERMISSION是权限申请码，用来标志权限申请的
            ActivityCompat.requestPermissions(this,permissions, RC_PERMISSION);
        }else {
            mPresenter.getUserInfo(-1);
        }
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        if (requestCode == RC_PERMISSION && grantResults.length == 4
                && grantResults[0] == PackageManager.PERMISSION_GRANTED
                && grantResults[1] == PackageManager.PERMISSION_GRANTED
                && grantResults[2] == PackageManager.PERMISSION_GRANTED
                && grantResults[3] == PackageManager.PERMISSION_GRANTED) {
            Log.e(TAG, "权限申请成功");
            mPresenter.getUserInfo(-1);
        }else {
            Log.e(TAG, "权限申请失败");
            MyToast.showMessage(getThisActivity(),getResources().getString(R.string.permission_prompt));
            finish();
        }
    }

    //into=1请求成功后进入CourseActivity
    @Override
    public void loginRsp(LoginRspBean loginRspBean, int into) {
        hideLoading();
        Config.publicUserId = String.valueOf(loginRspBean.getId());
        if(into==1){
            startActivity(new Intent(getThisActivity(), CourseActivity.class));
        }
    }

    @Override
    public void loginError(String code, String msg) {
        hideLoading();
        if ("999".equals(code)) {
            MyToast.showMessage(getThisActivity(), getResources().getString(R.string.network_connection_fail));
        }
    }

    @Override
    public void showToastMsg(String msg) {

    }

    @Override
    public void startAct(Intent intent) {

    }

    @Override
    public void startActForResult(Intent intent, int requestCode) {

    }
}
```

# restartApp

```java
private void restartApp(){
        Activity activity = (Activity) context;
        Intent intent = new Intent(activity, SplashActivity.class);
        intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TASK);
        activity.startActivity(intent);
        // 杀掉进程
        android.os.Process.killProcess(android.os.Process.myPid());
        System.exit(0);
    }
```

