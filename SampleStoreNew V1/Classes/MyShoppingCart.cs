using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using SampleStoreNew_V1.Data_Access;


namespace SampleStoreNew_V1.Classes
{
    public struct ShoppingCartUpdates
    {
        public int ProductId;
        public int PurchaseQuantity;
        public bool RemoveItem;
    }
    public partial class MyShoppingCart
    {
        public const string CartId = "TailSpinSpyWorks_CartID";

        public void AddItem(string cartID, int productID, int quantity)
        {
            using (CommerceEntities db = new CommerceEntities())
            {
                try
                {
                    var myItem = (from c in db.ShoppingCarts
                                  where c.CartID == cartID &&
                                      c.ProductID == productID
                                  select c).FirstOrDefault();
                    if (myItem == null)
                    {
                        ShoppingCart cartadd = new ShoppingCart();
                        cartadd.CartID = cartID;
                        cartadd.Quantity = quantity;
                        cartadd.ProductID = productID;
                        cartadd.DateCreated = DateTime.Now;
                        db.ShoppingCarts.AddObject(cartadd);
                    }
                    else
                    {
                        myItem.Quantity += quantity;
                    }
                    db.SaveChanges();
                }
                catch (Exception exp)
                {
                    throw new Exception("ERROR: Unable to Add Item to Cart - " +
                    exp.Message.ToString(), exp);
                }
            }
        }

        public String GetShoppingCartId()
        {
            if (HttpContext.Current.Session[CartId] == null)
            {
                HttpContext.Current.Session[CartId] = System.Web.HttpContext.Current.Request.IsAuthenticated ? HttpContext.Current.User.Identity.Name : Guid.NewGuid().ToString();
            }
            return HttpContext.Current.Session[CartId].ToString();
        }

        public void RemoveItem(string cartID, int productID)
        {
            using (CommerceEntities db = new CommerceEntities())
            {
                try
                {
                    var myItem = (from c in db.ShoppingCarts where c.CartID == cartID && c.ProductID == productID select c).FirstOrDefault();
                    if (myItem != null)
                    {
                        db.DeleteObject(myItem);
                        db.SaveChanges();
                    }

                }
                catch (Exception exp)
                {
                    throw new Exception("ERROR: Unable to Remove Cart Item - " + exp.Message.ToString(), exp);
                }
            }

        }

        public decimal GetTotal(string cartID)
        {
            using (CommerceEntities db = new CommerceEntities())
            {
                decimal cartTotal = 0;
                try
                {
                    var myCart = (from c in db.ViewCarts where c.CartID == cartID select c);
                    if (myCart.Count() > 0)
                    {
                        cartTotal = myCart.Sum(od => (decimal)od.Quantity * (decimal)od.UnitCost);
                    }
                }
                catch (Exception exp)
                {
                    throw new Exception("ERROR: Unable to Calculate Order Total - " +
                    exp.Message.ToString(), exp);
                }
                return (cartTotal);
            }
        }

        public void UpdateItem(string cartID, int productID, int quantity)
        {
            using (CommerceEntities db = new CommerceEntities())
            {
                try
                {
                    var myItem = (from c in db.ShoppingCarts where c.CartID == cartID && c.ProductID == productID select c).FirstOrDefault();
                    if (myItem != null)
                    {
                        myItem.Quantity = quantity;
                        db.SaveChanges();
                    }
                }
                catch (Exception exp)
                {
                    throw new Exception("ERROR: Unable to Update Cart Item - " + exp.Message.ToString(), exp);
                }
            }

        }

        //------------------------------------------------------------------------------------------------------------------------------------------+
        public void UpdateShoppingCartDatabase(String cartId, ShoppingCartUpdates[] CartItemUpdates)
        {
            using (CommerceEntities db = new CommerceEntities())
            {
                try
                {
                    int CartItemCOunt = CartItemUpdates.Count();
                    var myCart = (from c in db.ViewCarts where c.CartID == cartId select c);
                    foreach (var cartItem in myCart)
                    {
                        // Iterate through all rows within shopping cart list
                        for (int i = 0; i < CartItemCOunt; i++)
                        {
                            if (cartItem.ProductID == CartItemUpdates[i].ProductId)
                            {
                                if (CartItemUpdates[i].PurchaseQuantity < 1 || CartItemUpdates[i].RemoveItem == true)
                                {
                                    RemoveItem(cartId, cartItem.ProductID);
                                }
                                else
                                {
                                    UpdateItem(cartId, cartItem.ProductID, CartItemUpdates[i].PurchaseQuantity);
                                }
                            }
                        }
                    }
                }
                catch (Exception exp)
                {
                    throw new Exception("ERROR: Unable to Update Cart Database - " + exp.Message.ToString(), exp);
                }
            }
        }

    }
}