import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { ProductsComponent } from './pages/products/products.component';
import { StaffComponent } from './pages/staff/staff.component';

const routes: Routes = [
  {path: 'products', component: ProductsComponent},
  {path: 'staffs', component: StaffComponent}
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
