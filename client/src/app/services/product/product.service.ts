import { Injectable } from '@angular/core';
import {HttpClient, HttpHeaders} from '@angular/common/http';
import { Observable, catchError, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root'
})
export class ProductService {
  private productUrl = 'http://127.0.0.1:4100/api/v1/item?shop_id=1';

  constructor(private httpClient: HttpClient) { }

  fetchProducts(): Observable<any> {
    const token: string = environment.userToken || '';
    const header: HttpHeaders = new HttpHeaders({
      'Content-Type': 'application/json',
      'Authorization': token
    })
    return this.httpClient
      .get<any>(this.productUrl, {headers: header})
      .pipe(catchError((error: any) => {
        return throwError(() => {
          let err = new Error('error in fetching products');
          err.message = error.error.error;
          return err;
        });
      })
    );
  }
}
