---
title: Splunk Application Performance Monitoring Home page
linkTitle: 2. APM Home Page
weight: 20
---
 
{{% button icon="clock" %}}7 minutes{{% /button %}}

As we will dive deeper into Splunk Application Performance Monitoring, or APM, later in the workshop, we will just visit some of they key part of APM in this initial tour.

Let's start, please select ![APM](../images/apm-icon.png?classes=inline&height=25px) from the Main menu if you have not done so already. This will bring you to the APM Home page.  

This Page has 4 distinct sections that provide information or allows you to navigate the APM UI.

![apm page](../images/apm-main.png?width=30vw)

1. Onboarding Pane Pane. Here you will find video's and references to document pages of interest for APM  
(Can be closed by the **X** on the right, if space is at a premium.)
2. APM Overview Pane. This pane shows you dashboards of consolidated and unsampled trace information for  a real-time snapshot of your services behaviour.
3. Functions Pane. This pane allows for quick movement between the different key functions that make up Splunk APM.

{{% notice title=" About Environments" style="info" %}}
Usually you will have multiple teams or applications send Trace data to Splunk APM. To differentiate between these teams or application, Splunk uses environments. And users can work with one or more environment at the same time. However, in this workshop everything is contained in one single environment.  
The naming convention for your environment is *[NAME OF WORKSHOP]-workshop*. Your instructor can provide you with the correct name.

{{% /notice %}}

{{% notice title="Info" style="green" title="Exercise" icon="running" %}}

* First, verify that time window we are working with is set to the last 15 minutes.  If this is not the case, change it by using the drop down in APM Overview Pane ![time-window](../../images/time-window.png?classes=inline) at the top of the page and set it to *the last 15 minutes*.
* Change the environment to the workshop one by selecting its name from the drop down box and make sure that is the only one with a ![blue tick](../../images/blue-tick.png?classes=inline) in front of it.
* Now, lets have a look at our service Map.  This map will show you how your components/services interact together in the selected time frame based on the Trace  information send to the Splunk Observability Suite.
* Click on the Explore Tile in the Function Pane. This will bring use to the automatically generated map of our service interaction.

![APM Map](../images/apm-map.png?width=30vw)

{{% /notice %}}

We will investigate APM in more detail later, so lets have a look at  how Real User Monitoring works in the next page.