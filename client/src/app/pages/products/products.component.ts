import { Component } from '@angular/core';
import { ProductService } from '../../services/product/product.service';
import { NotificationService } from '../../services/notification/notification.service';

interface Product {
  title: string;
  id: number;
  description: string;
  price: number;
};

@Component({
  selector: 'app-products',
  templateUrl: './products.component.html',
  styleUrls: ['./products.component.scss']
})
export class ProductsComponent {
  constructor(private productService: ProductService, private notificationService: NotificationService) {}
  isLoading: Boolean = true;
  products: Array<Product> = [];
  filterString: string = '';

  getProducts(): Array<Product> {
    if (!this.filterString) return this.products; 
    return this.products.filter((product: Product) => {
      return product.title.includes(this.filterString);
    })
  };

  ngOnInit() {
    this.productService.fetchProducts().subscribe(
      (data) => { 
        this.isLoading = false;
        this.products = data.items;
      },
      (error) => { 
        console.error(error); 
        this.notificationService.showSuccess('error occure')
      }
    );
  }
}