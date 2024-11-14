import 'package:t_store/features/shop/models/banner_model.module.dart';
import 'package:t_store/features/shop/models/brand_model.module.dart';
import 'package:t_store/features/shop/models/category_model.module.dart';
import 'package:t_store/features/shop/models/product_attribute_model.module.dart';
import 'package:t_store/features/shop/models/product_model.module.dart';
import 'package:t_store/features/shop/models/product_variation_model.module.dart';
import 'package:t_store/features/shop/models/relashtions/brand_category_model.module.dart';
import 'package:t_store/features/shop/models/relashtions/product_category_model.module.dart';
import 'package:t_store/routes/routes.dart';
import 'package:t_store/utils/constants/image_strings.dart';

class TDummyData {
  // --- Banners
  static final List<BannerModel> banners = [
    BannerModel(
        imageUrl: TImages.promoBanner1,
        targetScreen: TRoutes.order,
        active: false),
    BannerModel(
        imageUrl: TImages.promoBanner2,
        targetScreen: TRoutes.cart,
        active: true),
    BannerModel(
        imageUrl: TImages.promoBanner3,
        targetScreen: TRoutes.favourites,
        active: true),
    BannerModel(
        imageUrl: TImages.promoBanner4,
        targetScreen: TRoutes.search,
        active: true),
  ];

  // --- User
  // static final UserModel user = UserModel(
  //   // id: id,
  //   firstName: 'Coding',
  //   lastName: 'with T',
  //   userName: 'khaled tarek',
  //   email: 'tkhaled238@gmail.com',
  //   phoneNumber: '01069785676',
  //   profilePicture: TImages.user,
  //   addresses: [
  //     AddressModel(
  //       id: '1',
  //       name: 'Coding with T',
  //       phoneNumber: '01069785676',
  //       street: '82356 Timmy Coves',
  //       state: 'Maine',
  //       postalCode: '87665',
  //       country: 'USA',
  //     ),
  //     AddressModel(
  //       id: '6',
  //       name: 'Coding with T',
  //       phoneNumber: '01069785676',
  //       street: '82356 Timmy Coves',
  //       state: 'Maine',
  //       postalCode: '87665',
  //       country: 'USA',
  //     ),
  //   ],
  // );

  // --- Cart
  // static final CartModel cart = CartModel(
  //   cartId: '001',
  //   items: [
  //     CartItemModel(
  //       productId:'001',
  //       variationId: '1',
  //       quantity: 1,
  //       title: products[0].title,
  //       image: products[0].thumbnail,
  //       brandName: products[0].brand!.name,
  //       price: products[0].productVariations![0].price,
  //       selectedVariation:products[0].productVariations![0].attributeValues,
  //     ),
  //     CartItemModel(
  //       productId:'001',
  //       variationId: '1',
  //       quantity: 1,
  //       title: products[0].title,
  //       image: products[0].thumbnail,
  //       brandName: products[0].brand!.name,
  //       price: products[0].productVariations![0].price,
  //       selectedVariation:products[0].productVariations![0].attributeValues,
  //     ),
  //   ],
  // );

  // --- Order
  // static final List<OrderModel> orders = [
  //   OrderModel(
  //     id:'CWT0012',
  //     status:OrderStatus.processing,
  //     items: cart.items,
  //     totalAmount:256,
  //     orderDate: DateTime(2023 , 09 , 1),
  //     deliveryDate: DateTime(2023 , 09 , 9),
  //   ),
  //   OrderModel(
  //     id:'CWT0012',
  //     status:OrderStatus.processing,
  //     items: cart.items,
  //     totalAmount:256,
  //     orderDate: DateTime(2023 , 09 , 1),
  //     deliveryDate: DateTime(2023 , 09 , 9),
  //   ),
  // ];

  // --- List of all Categories
  static final List<CategoryModel> categories = [
    CategoryModel(
        id: '1', image: TImages.sports, name: 'Sports', isFeatured: true),
    CategoryModel(
        id: '2',
        image: TImages.electronics,
        name: 'Electronics',
        isFeatured: true),
    CategoryModel(
        id: '3', image: TImages.clothes, name: 'Clothes', isFeatured: true),
    CategoryModel(
        id: '4', image: TImages.animals, name: 'Animals', isFeatured: true),
    CategoryModel(
        id: '5', image: TImages.furniture, name: 'Furniture', isFeatured: true),
    CategoryModel(
        id: '6', image: TImages.shoes, name: 'Shoes', isFeatured: true),
    CategoryModel(
        id: '7',
        image: TImages.cosmestics,
        name: 'Cosmetics',
        isFeatured: true),
    CategoryModel(
        id: '14', image: TImages.jewerly, name: 'Jewelery', isFeatured: true),

    // subcotegories Sports
    CategoryModel(
        id: '8',
        image: TImages.sports,
        name: 'Sports Shoes',
        parentId: '1',
        isFeatured: false),
    CategoryModel(
        id: '9',
        image: TImages.sports,
        name: 'Track Suits',
        parentId: '1',
        isFeatured: false),
    CategoryModel(
        id: '10',
        image: TImages.sports,
        name: 'Sports Equipments',
        parentId: '1',
        isFeatured: false),

    // subcotegories Furniture
    CategoryModel(
        id: '11',
        image: TImages.furniture,
        name: 'Bedroom Furniture',
        parentId: '5',
        isFeatured: false),
    CategoryModel(
        id: '12',
        image: TImages.furniture,
        name: 'Kitchen Furniture',
        parentId: '5',
        isFeatured: false),
    CategoryModel(
        id: '13',
        image: TImages.furniture,
        name: 'Office Furniture',
        parentId: '5',
        isFeatured: false),

    // subcotegories Electronics
    CategoryModel(
        id: '14',
        image: TImages.electronics,
        parentId: '2',
        name: 'Laptop',
        isFeatured: false),
    CategoryModel(
        id: '15',
        image: TImages.electronics,
        name: 'Mobile',
        parentId: '2',
        isFeatured: false),

    // subcotegories Clothes
    CategoryModel(
        id: '16',
        image: TImages.clothes,
        name: 'Shirts',
        parentId: '3',
        isFeatured: false),
  ];

  // --- List of all products
  static final List<ProductModel> products = [
    ProductModel(
      id: '001',
      title: 'Green Nike sports shoe',
      stock: 15,
      price: 135,
      isFeatured: true,
      thumbanil: TImages.productImage22,
      description: 'Green Nike sports shoe',
      brand: BrandModel(
          id: '1',
          name: 'NIKE',
          image: TImages.nikeLogo,
          productsCount: 265,
          isFeatured: true),
      images: [
        TImages.productImage22,
        TImages.productImage21,
        TImages.productImage6
      ],
      salePrice: 30,
      sku: 'ABR4568',
      categoryId: '1',
      productAttributes: [
        ProductAttributeModel(name: 'Color', values: ['Green', 'Black', 'Red']),
        ProductAttributeModel(
            name: 'Size', values: ['EU 30', 'EU 32', 'EU 34']),
      ],
      productVariations: [
        ProductVariationModel(
            id: '1',
            stock: 34,
            price: 134,
            salePrice: 122.6,
            image: TImages.productImage22,
            description:
                'This is a Product description for Green Nike sports shoe.',
            attributesValues: {'Color': 'Green', 'Size': 'EU 34'}),
        ProductVariationModel(
            id: '2',
            stock: 15,
            price: 132,
            image: TImages.productImage21,
            attributesValues: {'Color': 'Black', 'Size': 'EU 32'}),
        ProductVariationModel(
            id: '3',
            stock: 0,
            price: 234,
            image: TImages.productImage21,
            attributesValues: {'Color': 'Black', 'Size': 'EU 34'}),
        ProductVariationModel(
            id: '4',
            stock: 222,
            price: 232,
            image: TImages.productImage22,
            attributesValues: {'Color': 'Green', 'Size': 'EU 32'}),
        ProductVariationModel(
            id: '5',
            stock: 0,
            price: 334,
            image: TImages.productImage6,
            attributesValues: {'Color': 'Red', 'Size': 'EU 34'}),
        ProductVariationModel(
            id: '6',
            stock: 11,
            price: 332,
            image: TImages.productImage6,
            attributesValues: {'Color': 'Red', 'Size': 'EU 32'}),
      ],
      productType: 'ProductType.variable',
    ),
    ProductModel(
      id: '002',
      title: 'Blue T-shirt for all ages',
      stock: 15,
      price: 35,
      isFeatured: true,
      thumbanil: TImages.productImage36,
      description:
          'This is a Product description for Blue Nike Sleeve less vest. There are more things that can be added but i am jsut practicing and nothing else.',
      brand: BrandModel(
        id: '2',
        name: 'ZARA',
        image: TImages.zaraLogo,
      ),
      images: [
        TImages.productImage37,
        TImages.productImage36,
        TImages.productImage4,
      ],
      salePrice: 30,
      sku: 'ABR4568',
      categoryId: '9',
      productAttributes: [
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
        ProductAttributeModel(name: 'Size', values: ['EU32', 'EU34']),
      ],
      productType: 'ProductType.single',
    ),

/*......................................................*/
    ProductModel(
      id: '003',
      title: 'Blue T-shirt for all ages',
      stock: 15,
      price: 35,
      isFeatured: true,
      thumbanil: TImages.productImage36,
      description:
          'This is a Product description for Blue Nike Sleeve less vest. There are more things that can be added but i am jsut practicing and nothing else.',
      brand: BrandModel(
        id: '2',
        name: 'ZARA',
        image: TImages.zaraLogo,
      ),
      images: [
        TImages.productImage37,
        TImages.productImage36,
        TImages.productImage4,
      ],
      salePrice: 30,
      sku: 'ABR4568',
      categoryId: '3',
      productAttributes: [
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
        ProductAttributeModel(name: 'Size', values: ['EU32', 'EU34']),
      ],
      productType: 'ProductType.single',
    ),

/*......................................................*/
    ProductModel(
      id: '004',
      title: 'Leather brown Jacket',
      stock: 15,
      price: 38000,
      isFeatured: false,
      thumbanil: TImages.productImage41,
      description:
          'This is a Product description for Leather brown Jacket. There are more things that can be added but i am jsut practicing and nothing else.',
      brand: BrandModel(
        id: '2',
        name: 'ZARA',
        image: TImages.zaraLogo,
      ),
      images: [
        TImages.productImage38,
        TImages.productImage39,
        TImages.productImage40,
        TImages.productImage41,
      ],
      salePrice: 30,
      sku: 'ABR4568',
      categoryId: '3',
      productAttributes: [
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
        ProductAttributeModel(name: 'Size', values: ['EU32', 'EU34']),
      ],
      productType: 'ProductType.single',
    ),

/*......................................................*/
    ProductModel(
      id: '005',
      title: '4 Color collar t-shirt dry fit',
      stock: 15,
      price: 135,
      isFeatured: false,
      thumbanil: TImages.productImage44,
      description:
          'This is a Product description for 4 Color collar t-shirt dry fit. There are more things that can be added but i am jsut practicing and nothing else.',
      brand: BrandModel(
        id: '2',
        name: 'ZARA',
        image: TImages.zaraLogo,
      ),
      images: [
        TImages.productImage44,
        TImages.productImage45,
        TImages.productImage43,
        TImages.productImage42,
      ],
      salePrice: 30,
      sku: 'ABR4568',
      categoryId: '3',
      productAttributes: [
        ProductAttributeModel(
            name: 'Color', values: ['Red', 'Yellow', 'Green', 'Blue']),
        ProductAttributeModel(
            name: 'Size', values: ['EU 30', 'EU 32', 'EU 34']),
      ],
      productVariations: [
        ProductVariationModel(
            id: '1',
            stock: 34,
            price: 134,
            salePrice: 122.6,
            image: TImages.productImage44,
            description:
                'This is a Product description for 4 Color collar t-shirt dry fit.',
            attributesValues: {'Color': 'Red', 'Size': 'EU 34'}),
        ProductVariationModel(
            id: '2',
            stock: 15,
            price: 132,
            image: TImages.productImage44,
            attributesValues: {'Color': 'Red', 'Size': 'EU 32'}),
        ProductVariationModel(
            id: '3',
            stock: 0,
            price: 234,
            image: TImages.productImage45,
            attributesValues: {'Color': 'Yellow', 'Size': 'EU 34'}),
        ProductVariationModel(
            id: '4',
            stock: 222,
            price: 232,
            image: TImages.productImage45,
            attributesValues: {'Color': 'Yellow', 'Size': 'EU 32'}),
        ProductVariationModel(
            id: '5',
            stock: 0,
            price: 334,
            image: TImages.productImage43,
            attributesValues: {'Color': 'Green', 'Size': 'EU 34'}),
        ProductVariationModel(
            id: '6',
            stock: 11,
            price: 332,
            image: TImages.productImage43,
            attributesValues: {'Color': 'Green', 'Size': 'EU 32'}),
        ProductVariationModel(
            id: '7',
            stock: 0,
            price: 334,
            image: TImages.productImage42,
            attributesValues: {'Color': 'Blue', 'Size': 'EU 34'}),
        ProductVariationModel(
            id: '8',
            stock: 11,
            price: 332,
            image: TImages.productImage42,
            attributesValues: {'Color': 'Blue', 'Size': 'EU 32'}),
      ],
      productType: 'ProductType.variable',
    ),

/*......................................................*/
    ProductModel(
      id: '006',
      title: 'Nike Air Jordon Shoes',
      stock: 15,
      price: 35,
      isFeatured: false,
      thumbanil: TImages.productImage9,
      description:
          'Nike Air Jordon Shoes for running. Quality product, Long Lasting',
      brand: BrandModel(
          id: '1',
          name: 'NIKE',
          image: TImages.nikeLogo,
          productsCount: 265,
          isFeatured: true),
      images: [
        TImages.productImage6,
        TImages.productImage7,
        TImages.productImage8,
        TImages.productImage9,
      ],
      salePrice: 30,
      sku: 'ABR4568',
      categoryId: '8',
      productAttributes: [
        ProductAttributeModel(
            name: 'Color', values: ['Orange', 'Black', 'Brown']),
        ProductAttributeModel(
            name: 'Size', values: ['EU 30', 'EU 32', 'EU 34']),
      ],
      productVariations: [
        ProductVariationModel(
            id: '1',
            stock: 16,
            price: 36,
            salePrice: 12.6,
            image: TImages.productImage7,
            description:
                'Flutter is Google\'s mobile UI open source framework to build high-quality native (super fast) interfaces for iOS and Android apps with the unified codebase',
            attributesValues: {'Color': 'Orange', 'Size': 'EU 34'}),
        ProductVariationModel(
            id: '2',
            stock: 15,
            price: 35,
            image: TImages.productImage6,
            attributesValues: {'Color': 'Black', 'Size': 'EU 32'}),
        ProductVariationModel(
            id: '3',
            stock: 14,
            price: 34,
            image: TImages.productImage9,
            attributesValues: {'Color': 'Brwon', 'Size': 'EU 34'}),
        ProductVariationModel(
            id: '4',
            stock: 13,
            price: 33,
            image: TImages.productImage6,
            attributesValues: {'Color': 'Black', 'Size': 'EU 34'}),
        ProductVariationModel(
            id: '5',
            stock: 12,
            price: 32,
            image: TImages.productImage9,
            attributesValues: {'Color': 'Brwon', 'Size': 'EU 32'}),
        ProductVariationModel(
            id: '6',
            stock: 11,
            price: 31,
            image: TImages.productImage7,
            attributesValues: {'Color': 'Orange', 'Size': 'EU 32'}),
      ],
      productType: 'ProductType.variable',
    ),
  ];

  static final List<BrandModel> brands = [
    BrandModel(
        id: '1',
        name: 'NIKE',
        image: TImages.nikeLogo,
        productsCount: 265,
        isFeatured: true),
    BrandModel(
        id: '2',
        name: 'ZARA',
        image: TImages.zaraLogo,
        productsCount: 300,
        isFeatured: true),
    BrandModel(
        id: '3',
        name: 'ACER',
        image: TImages.acerLogo,
        productsCount: 50,
        isFeatured: true),
    BrandModel(
        id: '4',
        name: 'ADIDAS',
        image: TImages.adidasLogo,
        productsCount: 212,
        isFeatured: true),
    BrandModel(
        id: '5',
        name: 'APPLE',
        image: TImages.appleLogo,
        productsCount: 120,
        isFeatured: true),
    BrandModel(
        id: '6',
        name: 'IKEA',
        image: TImages.ikeyalogo,
        productsCount: 320,
        isFeatured: true),
    BrandModel(
        id: '7',
        name: 'JORDAN',
        image: TImages.jordanLogo,
        productsCount: 265,
        isFeatured: true),
    BrandModel(
        id: '8',
        name: 'KENWOOD',
        image: TImages.kenwoodLogo,
        productsCount: 150,
        isFeatured: true),
    BrandModel(
        id: '9',
        name: 'PUMA',
        image: TImages.pumaLogo,
        productsCount: 265,
        isFeatured: true),
    BrandModel(
        id: '10',
        name: 'SAMSOUNG',
        image: TImages.smasoungLogo,
        productsCount: 265,
        isFeatured: true),
  ];

  static final List<BrandCategoryModel> brandCategory = [
    BrandCategoryModel(brandId: '1', categoryId: '1'),
    BrandCategoryModel(brandId: '4', categoryId: '1'),
    BrandCategoryModel(brandId: '10', categoryId: '2'),
    BrandCategoryModel(brandId: '5', categoryId: '2'),
    BrandCategoryModel(brandId: '6', categoryId: '3'),
    BrandCategoryModel(brandId: '2', categoryId: '3'),
    BrandCategoryModel(brandId: '7', categoryId: '3'),
    BrandCategoryModel(brandId: '8', categoryId: '4'),
    BrandCategoryModel(brandId: '9', categoryId: '4'),
    BrandCategoryModel(brandId: '3', categoryId: '5'),
    BrandCategoryModel(brandId: '6', categoryId: '5'),
    BrandCategoryModel(brandId: '1', categoryId: '6'),
    BrandCategoryModel(brandId: '4', categoryId: '6'),
    BrandCategoryModel(brandId: '7', categoryId: '6'),
    BrandCategoryModel(brandId: '2', categoryId: '7'),
    BrandCategoryModel(brandId: '1', categoryId: '7'),
    BrandCategoryModel(brandId: '8', categoryId: '8'),
    BrandCategoryModel(brandId: '2', categoryId: '8'),
  ];

  static final List<ProductCategoryModel> productCategories = products
      .map((product) => ProductCategoryModel(
            productId: product.id,
            categoryId: product.categoryId!,
          ))
      .toList();
}
