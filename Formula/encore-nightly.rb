class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230731"
    checksums = {
        "darwin_arm64" => "7ce907666ac86f414e1b06d7bcda636abd50853dc33bacc8530c8fe6938d89c0",
        "darwin_amd64" => "39c2525890ae2d6a752c1724769a3ab86ffa9840d02c7eaeda187a3c7e122cad",
        "linux_arm64"  => "d714d3711ccdbe43e23151500cbbaba66bd8c330d42233ef51f31be859766ce9",
        "linux_amd64"  => "f7431e9c8605920e028dc6a967527f2ddad3a1fcc8422b35e06011c3e53f5f36",
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
