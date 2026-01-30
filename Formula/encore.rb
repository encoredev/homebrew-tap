class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.54.0"
    checksums = {
        "darwin_arm64" => "3b3bb4cddf8d2dd8fa05d809b034c4413eb3ffda6f43063f3383f10eb6b7d069",
        "darwin_amd64" => "ba72538465399a700ddcc07da8516f2ca1c1c38cc1a99434d6c47337c6faaebc",
        "linux_arm64"  => "7f0e83c9f1e9c2169816891e7722bcbc99ce51a921234165c64e9898aae64b2e",
        "linux_amd64"  => "97cc3e9e6ea3a99fa4ad74572e3b567fe88c20185a8d16cc812b275edb5126b0",
    }

    arch = "arm64"
    platform = "darwin"
    on_intel do
        arch = "amd64"
    end
    on_linux do
        platform = "linux"
    end

    url "https://d2f391esomvqpi.cloudfront.net/encore-#{release_version}-#{platform}_#{arch}.tar.gz"
    version release_version
    sha256 checksums["#{platform}_#{arch}"]

    def install
        libexec.install Dir["*"]

        bin.install_symlink Dir[libexec/"bin/*"]


        # Install bash completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "bash")
        (bash_completion/"encore").write output

        # Install zsh completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "zsh")
        (zsh_completion/"_encore").write output

        # Install fish completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "fish")
        (fish_completion/"encore.fish").write output
    end

    test do
        system "#{bin}/encore", "check"
    end
end
