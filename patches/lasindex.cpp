#include <sciplot/sciplot.hpp>
using namespace sciplot;

int main(int argc, char** argv)
{
    // Create a vector with the xtic labels for the boxes
    Strings names = {"John", "Peter", "Thomas", "Marta"};

    // Create a vector with the y values for the boxes
    Vec ages = {44, 27, 35, 20};

    // Create a vector with the xwidth values for the boxes
    Vec experiences = {0.8, 0.4, 0.7, 0.9};

    // Create a Plot object
    Plot2D plot;

    // Set the legend to the top left corner of the plot
    plot.legend().atTopLeft();

    // Set the y label and its range
    plot.ylabel("Age");
    plot.yrange(0.0, 50);

    // Plot the boxes using y values.
    plot.drawBoxes(names, ages, experiences)
        .fillSolid()
        .fillColor("pink")
        .fillIntensity(0.5)
        .borderShow()
        .labelNone();

    // Adjust the relative width of the boxes
    plot.boxWidthRelative(0.75);

    plot.autoclean(false);

    // Create figure to hold plot
    Figure fig = {{plot}};
    // Create canvas to hold figure
    Canvas canvas = {{fig}};

    // Show the plot in a pop-up window
    canvas.show();

    // Save the plot to a PDF file
    canvas.save("example-boxes-ticklabels.pdf");
}
