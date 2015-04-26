shinyUI(pageWithSidebar(
    headerPanel("Vehicle Range Estimator"),
    sidebarPanel(
        helpText("A linear regression model has been fit to the mtcars data set to predict MPG based on vehicle transmission type, weight and number of cylinders. The model is used to predict the MPG of a fictive vehicle. The MPG is then used to plot the range of the vehicle based on nunber of gallons of gas in the tank."),
        helpText("Change the vehicle parameters below to show the predicted range of the fictive vehicle in the plot to the right."),
        radioButtons('cyl', 'Cylinders', choices = list("4" = 4, "6" = 6, "8" = 8), selected = 4, inline = TRUE),
        radioButtons("am", 'Transmission Type', choices = list("Automatic" = 1, "Manual" = 0), selected = 1, inline = TRUE),
        sliderInput('wt', 'Weight (lb)', value = 3200, min = 1500, max = 5500, step = 100)
    ),
    mainPanel(
        plotOutput('rangePlot'),
        helpText("The plot above shows the predicted range of a vehicle based on the vehicle parameters set by the user. Both the predicted fit and the 95% confidence interval are included in the plot.")
    )
))
