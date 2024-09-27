using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace de1.UserControl
{
    public partial class ucManageProduct : System.Web.UI.UserControl
    {
        protected void BindGridView()
        {
            QLKhoaHocEntities context = new QLKhoaHocEntities();
            var query = (from p in context.Courses select p).ToList<Course>();
            GridViewProducts.DataSource = query;
            GridViewProducts.DataBind();
        }
        protected void BindDropDownList()
        {
            QLKhoaHocEntities context = new QLKhoaHocEntities();
            DropDownListCategory.DataSource = (from c in context.Categories select c).ToList<Category>();
            DropDownListCategory.DataTextField = "CatName";
            DropDownListCategory.DataValueField = "CatID";
            DropDownListCategory.DataBind();

            dpEditProductCategory.DataSource = (from c in context.Categories select c).ToList<Category>();
            dpEditProductCategory.DataTextField = "CatName";
            dpEditProductCategory.DataValueField = "CatID";
            dpEditProductCategory.DataBind();
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGridView();
                BindDropDownList();
            }
        }



        protected void GridViewProducts_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridViewProducts.PageIndex = e.NewPageIndex;

            BindGridView();
        }

        protected void GridViewProducts_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int id = int.Parse(e.CommandArgument.ToString());
            QLKhoaHocEntities context = new QLKhoaHocEntities();

            if (e.CommandName == "EditProduct")
            {
                var course = (from p in context.Courses
                              where p.ID == id
                              select p).SingleOrDefault();

                if (course != null)
                {
                    lblProductId.Text = course.ID.ToString(); // Ghi lại ID để cập nhật
                    txtEditProductName.Text = course.Name;
                    txtEditProductPrice.Text = course.Duration.ToString();
                    txtEditProductDescription.Text = course.Description;
                    dpEditProductCategory.SelectedValue = course.CatID.ToString();
                    pnlEditProduct.Visible = true; // Hiện form cập nhật
                }
            }
            else if (e.CommandName == "DeleteProduct")
            {
                var product = (from p in context.Courses
                               where p.ID == id
                               select p).SingleOrDefault();
                if (product != null)
                {
                    context.Courses.Remove(product);
                    context.SaveChanges();
                    BindGridView();
                }
            }
        }



        protected void ButtonAddNew_Click(object sender, EventArgs e)
        {
            string filename = "";
            if (FileUploadPicture.HasFile)
            {
                filename = FileUploadPicture.FileName;
                FileUploadPicture.SaveAs(Server.MapPath("~/images/Courses/" + filename));
            }

            QLKhoaHocEntities context = new QLKhoaHocEntities();
            Course p = new Course();
            // Không cần gán giá trị cho ProductID nếu nó là cột tự động tăng (identity)
            p.Name = TextBoxName.Text;
            p.Duration = Convert.ToInt32(TextBoxDuration.Text);
            p.Description = TextBoxDescription.Text;
            p.CatID = int.Parse(DropDownListCategory.SelectedValue);
            p.ImageFilePath = filename;

            context.Courses.Add(p);
            context.SaveChanges();

            BindGridView(); // Cập nhật lại dữ liệu trong GridView
            Page.Master.DataBind();
        }

        protected void btnUpdateProduct_Click(object sender, EventArgs e)
        {
            QLKhoaHocEntities context = new QLKhoaHocEntities();
            int productId = int.Parse(lblProductId.Text);
            var product = (from p in context.Courses
                           where p.ID == productId
                           select p).SingleOrDefault();

            if (product != null)
            {
                product.Name = txtEditProductName.Text;
                product.Duration = Convert.ToInt32(TextBoxDuration.Text);
                product.Description = txtEditProductDescription.Text;
                product.CatID = int.Parse(dpEditProductCategory.SelectedValue);

                // Kiểm tra nếu có file ảnh mới
                if (fulEditImageProduct.HasFile)
                {
                    string filename = fulEditImageProduct.FileName;
                    fulEditImageProduct.SaveAs(Server.MapPath("~/images/Courses/" + filename));
                    product.ImageFilePath = filename; // Cập nhật đường dẫn file
                }

                context.SaveChanges(); // Lưu các thay đổi
                BindGridView(); // Cập nhật lại GridView
                pnlEditProduct.Visible = false; // Ẩn form cập nhật
                Page.Master.DataBind();
            }
        }
        protected void btnCancelUpdate_Click(object sender, EventArgs e)
        {
            pnlEditProduct.Visible = false; // Ẩn form cập nhật
        }

        protected void TextBoxName_TextChanged(object sender, EventArgs e)
        {

        }
    }

}
