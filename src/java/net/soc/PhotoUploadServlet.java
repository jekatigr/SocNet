package net.soc;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;
import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 * Servlet implementation class UploadServlet
 */
public class PhotoUploadServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String DATA_DIRECTORY = "pic/photos";
    private static final int MAX_MEMORY_SIZE = 1024 * 1024 * 100;
    private static final int MAX_REQUEST_SIZE = 1024 * 1024 * 100;
    private static final int MAX_PHOTO_SIZE = 1024 * 1024 * 10;
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        // Check that we have a file upload request
        boolean isMultipart = ServletFileUpload.isMultipartContent(request);

        HttpSession session = request.getSession();
        
        if (!isMultipart) {
            session.setAttribute("photo_upload_error", "You didn't choose the file!");
        } else {
            // Create a factory for disk-based file items
            DiskFileItemFactory factory = new DiskFileItemFactory();

            // Sets the size threshold beyond which files are written directly to
            // disk.
            factory.setSizeThreshold(MAX_MEMORY_SIZE);

            // Sets the directory used to temporarily store files that are larger
            // than the configured size threshold. We use temporary directory for
            // java
            factory.setRepository(new File(System.getProperty("java.io.tmpdir")));

            // constructs the folder where uploaded file will be stored
            String uploadFolder = getServletContext().getRealPath("")
                    + File.separator + DATA_DIRECTORY;

            // Create a new file upload handler
            ServletFileUpload upload = new ServletFileUpload(factory);

            // Set overall request size constraint
            upload.setSizeMax(MAX_REQUEST_SIZE);

            int user_id = Integer.parseInt(session.getAttribute("id").toString());
            String hash = String.valueOf(session.getAttribute("hash"));

            if ((new AuthBean()).checkAuth(user_id, hash)) {//check user authentication
                try {
                    // Parse the request
                    List items = upload.parseRequest(request);
                    Iterator iter = items.iterator();
                    if (iter.hasNext()) {
                        FileItem item = (FileItem) iter.next();

                        if (!item.isFormField()) {
                            String fileName = new File(item.getName()).getName();
                            String filePath = uploadFolder + File.separator + fileName;

                            String ct = item.getContentType();
                            if (ct.equals("image/jpeg") || 
                                    ct.equals("image/jpg") || 
                                    ct.equals("image/png") || 
                                    ct.equals("image/gif") || 
                                    ct.equals("image/bmp")) {
                                if (item.getSize() < MAX_PHOTO_SIZE) {
                                    File uploadedFile = new File(filePath);
                                    // saves the file to upload directory
                                    item.write(uploadedFile);
                                    File f = prepareImageForAvatar(filePath);
                                    session.setAttribute("photo_upload_success", true);
                                } else {
                                    session.setAttribute("photo_upload_error", "Uploaded file is too big!");
                                }
                            } else {
                                session.setAttribute("photo_upload_error", "Wrong type of file!");
                            }                        
                        }
                    } else {
                        session.setAttribute("photo_upload_error", "You didn't choose the file!");
                    }
                } catch (FileUploadException ex) {
                    throw new ServletException(ex);
                } catch (Exception ex) {
                    throw new ServletException(ex);
                }
            }
        }
        //moving back
        response.sendRedirect(getServletContext().getContextPath() + "/edit_profile.jsp");
    }
    
    //crop & resize
    private File prepareImageForAvatar(String path) throws IOException {
        File res = new File(path);
        BufferedImage in = ImageIO.read(res);
        in = Crop(in);
        in = Resize(in);
        ImageIO.write(in, "jpg", res);
        return res;
    }

    private BufferedImage Crop(BufferedImage in) {
        BufferedImage dest = in.getSubimage(0, 0, Math.min(in.getHeight(), in.getWidth()), Math.min(in.getHeight(), in.getWidth()));
        return dest; 
    }

    private BufferedImage Resize(BufferedImage in) {
    	BufferedImage scaledBI = new BufferedImage(400, 400, BufferedImage.TYPE_INT_RGB);
    	Graphics2D g = scaledBI.createGraphics();
    	g.drawImage(in, 0, 0, 400, 400, null); 
    	g.dispose();
    	return scaledBI;
    }
}