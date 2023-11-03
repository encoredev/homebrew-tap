class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20231103"
    checksums = {
        "darwin_arm64" => "3c281cd1ac4d11b4dd4486c8a82bc79c1cb2d324afa853e82c94d9e7c8071387",
        "darwin_amd64" => "290edfa09fa85ed21eaefa8a9aa058bae80fc471582851392826d47237b2f0d7",
        "linux_arm64"  => "fc19d83fa8ca7a660c3011eca6e6af51646d29f71ee9453826f67d6cad60e7c0",
        "linux_amd64"  => "038fe2a9c96c417ff89aad263bc6fe20d2c9624557304a03cae343f69532afab",
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
