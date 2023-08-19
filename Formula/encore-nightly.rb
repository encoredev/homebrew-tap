class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230819"
    checksums = {
        "darwin_arm64" => "9f10bd4e4dcd270d891ba7993872d58f4b69403d9adf47a68612b9d21aef9817",
        "darwin_amd64" => "62682e8a03e365fde835652704bbf70cd823052399bf7011fe2e70458359afda",
        "linux_arm64"  => "b436a40beede70faf18fc8d7892d6099a62246bd0e3f2fec82a47446e44e23c9",
        "linux_amd64"  => "d6614e277dfae674e1cfb81730b7e74064a34b4622a0f7de6d15b339b69ff254",
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
