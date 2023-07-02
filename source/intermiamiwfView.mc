import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class intermiamiwfView extends WatchUi.WatchFace {
	var logo;
	var messiImage;
    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.WatchFace(dc));
        logo = WatchUi.loadResource(Rez.Drawables.Logo);
        messiImage = WatchUi.loadResource(Rez.Drawables.Messi);
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Get the current time and format it correctly
        var timeFormat = "$1$:$2$";
        var clockTime = System.getClockTime();
        var hours = clockTime.hour;
        if (!System.getDeviceSettings().is24Hour) {
            if (hours > 12) {
                hours = hours - 12;
            }
        } else {
            if (getApp().getProperty("UseMilitaryFormat")) {
                timeFormat = "$1$$2$";
                hours = hours.format("%02d");
            }
        }
        var timeString = Lang.format(timeFormat, [hours, clockTime.min.format("%02d")]);

        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
        
        var widthScreen = dc.getWidth();
		var heightScreen = dc.getHeight();
  		var widthCenter = widthScreen / 2;
  		
  		// Lines
  	    dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
		dc.fillRectangle(0,0, widthScreen / 3 , heightScreen);
		
		dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
		dc.fillRectangle(widthScreen / 4,0, 10 , heightScreen);
		
		dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
		dc.fillRectangle(widthScreen / 3 * 2, 0, widthScreen / 2, heightScreen);
		
		dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
		dc.fillRectangle((widthScreen * 3 / 4) - 10,0, 10 , heightScreen);
		
		// Horizontal Line
		dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
		dc.fillRectangle(0,(heightScreen / 2) - 5, widthScreen, 10);
		
  		// Logo
        var positionLogoX = (widthScreen / 2) -50;
        var positionLogoY = (heightScreen / 2) - 50;
        dc.drawBitmap(positionLogoX, positionLogoY, logo);
        
		// Messi Image
		var positionMessiX = (widthScreen / 2) - messiImage.getWidth() / 2;
		var proportionAboveIcon = 0.3; // Esta es la proporción del espacio disponible por encima del icono que quieres que ocupe Messi.
		var positionMessiY = (heightScreen/ 2 * proportionAboveIcon) - (messiImage.getHeight() / 2);
		dc.drawBitmap(positionMessiX, positionMessiY, messiImage);

  		dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
        dc.drawText(widthCenter, (heightScreen / 8) * 6, Graphics.FONT_LARGE, timeString, Graphics.TEXT_JUSTIFY_CENTER);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() as Void {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() as Void {
    }

}
