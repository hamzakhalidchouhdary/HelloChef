import { Component } from '@angular/core';
import { ProductService } from '../services/product/product.service';

@Component({
  selector: 'app-products',
  templateUrl: './products.component.html',
  styleUrls: ['./products.component.scss']
})
export class ProductsComponent {
  constructor(private productService: ProductService) {}

  ngOnInit() {
    this.productService.fetchProducts().subscribe(
      (data) => { console.log(data); },
      (error) => { console.error(error); }
    );
  }
}
