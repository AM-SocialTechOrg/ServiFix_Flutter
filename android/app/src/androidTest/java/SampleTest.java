package java;

import io.appium.java_client.remote.options.BaseOptions;
import io.appium.java_client.android.AndroidDriver;
import java.net.URL;
import java.time.Duration;
import java.util.Arrays;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.openqa.selenium.*;

public class SampleTest {

    private AndroidDriver driver;

    @BeforeEach
    public void setUp() {
        var options = new BaseOptions()
                .amend("appium:automationName", "UiAutomator2")
                .amend("platformName", "Android")
                .amend("appium:deviceName", "Pixel_3a_API_34_extension_level_7_x86_64")
                .amend("appium:platformVersion", "14")
                .amend("appium:udid", "emulator-5554")
                .amend("appium:appActivity", "com.socialtech.servifix_flutter.MainActivity")
                .amend("appium:appPackage", "com.socialtech.servifix_flutter")
                .amend("appium:ensureWebviewsHavePages", true)
                .amend("appium:nativeWebScreenshot", true)
                .amend("appium:newCommandTimeout", 3600)
                .amend("appium:connectHardwareKeyboard", true);

        private URL getUrl() {
            try {
                return new URL("http://127.0.0.1:4723/wd/hub");
            } catch (MalformedURLException e) {
                e.printStackTrace();
            }
        }

        driver = new AndroidDriver(this.getUrl(), options);
    }

    @Test
    public void sampleTest() {

    }

    @AfterEach
    public void tearDown() {
        driver.quit();
    }
}
