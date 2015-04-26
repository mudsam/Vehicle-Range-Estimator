library(UsingR)
library(ggplot2)
data(mtcars)

# Create linear regression model using the mtcars dataset predicting
# MPG based on weight, transmission type and number of cylinders
model <- lm(mpg~wt+am+cyl, data=mtcars)

shinyServer(
    function(input, output) {
        output$rangePlot <- renderPlot({
            # Prepare input
            # Ensure it's numeric
            am<-as.numeric(input$am)
            cyl<-as.numeric(input$cyl)
            wt<-as.numeric(input$wt)/1000

            # Create dataframe for prediction
            df <- data.frame(wt=wt, am=am, cyl=cyl)

            # Get predicted MPG
            mpg.pred <- predict(model, df, interval="confidence", level=0.95)

            # Prepare plot data for 1-40 gallons in tank
            gallons_in_tank <- 1:40
            plot_df <- data.frame(x=gallons_in_tank, ylwr=mpg.pred[2]*gallons_in_tank, yupr=mpg.pred[3]*gallons_in_tank, yfit=mpg.pred[1]*gallons_in_tank)

            # Create plot for fit plus confint
            plot <- ggplot(plot_df, aes(x=x, y=yfit)) +
                theme_bw() +
                ggtitle("Range in miles with 95% confidence interval") +
                ylab("Miles") +
                xlab("Gallons in tank") +
                geom_point(data=plot_df, aes(x=x, y=yfit)) +
                geom_smooth(data=plot_df, aes(ymin=ylwr, ymax=yupr), stat="identity")
            print(plot)
        })
    }
)
