// Import xslt3
import xslt3 from 'xslt3';

// ...

// Define the transformXML function
async function transformXML(xmlString, xslString) {
  try {
    // Parse the XML and XSLT strings
    const parser = new DOMParser();
    const xmlDoc = parser.parseFromString(xmlString, 'text/xml');
    const xslDoc = parser.parseFromString(xslString, 'text/xml');

    // Create an XSLT processor
    const xsltProcessor = new xslt3.XSLT20Processor();

    // Set the XSL document
    await xsltProcessor.setDocument(xslDoc);

    // Transform the XML
    const resultDocument = await xsltProcessor.transformToDocument(xmlDoc);

    // Serialize the result document to an HTML string
    const serializer = new XMLSerializer();
    const htmlString = serializer.serializeToString(resultDocument);

    // Return the transformed HTML
    return htmlString;
  } catch (error) {
    console.error('XSLT Transformation Error:', error);
    return null;
  }
}

// ...

// Function to perform XSLT transformation
async function performXSLTTransformation(xslFileName) {
  try {
    // Load your XML content (replace with your XML file path)
    const xmlResponse = await fetch('/tei.xml');
    const xmlString = await xmlResponse.text();

    // Load your XSL content (replace with your XSL file path)
    const xslResponse = await fetch(`/${xslFileName}`);
    const xslString = await xslResponse.text();

    // Perform the XSLT transformation
    const transformedHtml = await transformXML(xmlString, xslString);

    if (transformedHtml) {
      // Display the transformed HTML
      document.getElementById('output').innerHTML = transformedHtml;
    }
  } catch (error) {
    console.error('XSLT Transformation Error:', error);
  }
}

// Perform XSLT transformation on page load
performXSLTTransformation('TEIManuscriptContents.xsl');
