class QuantityInput extends React.Component {
  constructor(props) {
    super(props)
    this.increment = this.increment.bind(this);
    this.decrement = this.decrement.bind(this);
    this.updateCartItem = this.updateCartItem.bind(this);

    this.state = { quantity: this.props.quantity || 1 }
  }

  updateCartItem(cart_item_id, quantity) {
    $.post(`/cart_items/${cart_item_id}`, {
      _method: "PUT",
      cart_item: {
        quantity: quantity,
      },
      id: this.props.cart_item_id,
      authenticity_token: this.props.authenticity_token
    })
    .then((response) => {
      this.setState({quantity: quantity});
    });
  }

  increment(e) {
    e.preventDefault();
    let cart_item_id = this.props.cart_item_id;
    let quantity = this.state.quantity;
    ++quantity;

    this.updateCartItem(cart_item_id, quantity)
  }

  decrement(e) {
    e.preventDefault();
    let cart_item_id = this.props.cart_item_id;
    let quantity = this.state.quantity;

    if(quantity <= 1)
      return
    else
      --quantity;

    this.updateCartItem(cart_item_id, quantity)
  }

  render () {
    return (
      <div className="qty-input">
        <a onClick={this.decrement} className="qty-button">
          <i className="fa fa-minus" aria-hidden="true"></i>
        </a>
        <span className="qty-text">{this.state.quantity}</span>
        <a onClick={this.increment} className="qty-button">
          <i className="fa fa-plus" aria-hidden="true"></i>
        </a>
      </div>
    )
  }
}
