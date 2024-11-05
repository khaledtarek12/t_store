import 'package:t_store/features/shop/models/banner_model.module.dart';
import 'package:t_store/features/shop/models/category_model.module.dart';
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
        id: '1', name: TImages.bowlingDark, image: 'Sports', isFeatured: true),
    CategoryModel(
        id: '2',
        name: TImages.smartphone,
        image: 'Electronics',
        isFeatured: true),
    CategoryModel(
        id: '3', name: TImages.clothIcon, image: 'Clothes', isFeatured: true),
    CategoryModel(
        id: '4', name: TImages.dogHeart, image: 'Animals', isFeatured: true),
    CategoryModel(
        id: '5',
        name: TImages.diningChair,
        image: 'Furniture',
        isFeatured: true),
    CategoryModel(
        id: '6', name: TImages.shoes, image: 'Shoes', isFeatured: true),
    CategoryModel(
        id: '7',
        name: TImages.cosmestics,
        image: 'Cosmetics',
        isFeatured: true),
    CategoryModel(
        id: '14',
        name: TImages.sparklingDiamond,
        image: 'Jewelery',
        isFeatured: true),

    // subcotegories Sports
    CategoryModel(
        id: '8',
        name: TImages.bowlingDark,
        image: 'Sports Shoes',
        parentId: '1',
        isFeatured: false),
    CategoryModel(
        id: '9',
        name: TImages.bowlingDark,
        image: 'Track Suits',
        parentId: '1',
        isFeatured: false),
    CategoryModel(
        id: '10',
        name: TImages.bowlingDark,
        image: 'Sports Equipments',
        parentId: '1',
        isFeatured: false),

    // subcotegories Furniture
    CategoryModel(
        id: '11',
        name: TImages.diningChair,
        image: 'Bedroom Furniture',
        parentId: '5',
        isFeatured: false),
    CategoryModel(
        id: '12',
        name: TImages.diningChair,
        image: 'Kitchen Furniture',
        parentId: '5',
        isFeatured: false),
    CategoryModel(
        id: '13',
        name: TImages.diningChair,
        image: 'Office Furniture',
        parentId: '5',
        isFeatured: false),

    // subcotegories Electronics
    CategoryModel(
        id: '14',
        name: TImages.smartphone,
        parentId: '2',
        image: 'Laptop',
        isFeatured: false),
    CategoryModel(
        id: '15',
        name: TImages.smartphone,
        image: 'Mobile',
        parentId: '2',
        isFeatured: false),

    // subcotegories Clothes
    CategoryModel(
        id: '16',
        name: TImages.clothIcon,
        image: 'Shirts',
        parentId: '3',
        isFeatured: false),
  ];
}
