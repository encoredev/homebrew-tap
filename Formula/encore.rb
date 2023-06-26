class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.21.0"
    checksums = {
        "darwin_arm64" => "97aa347b6b830c88b775dd7a80a4104f8f92d7c9317ad97a26b204b14775ca84",
        "darwin_amd64" => "fea8f67d2d9ea1feb03f919fb04a6cb3c72df84e01292ef1d580bd58361d0b49",
        "linux_arm64"  => "39b6d29540113283cdf9d433ee8823f1b70a434662fd7b6e895e56f27033dbf1",
        "linux_amd64"  => "3945a4efaaf732f0b573933bb335638f70e7580b48fa12858ad63969a42f9a86",
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
