class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20221027"
    checksums = {
        "darwin_arm64" => "df3680c2f652d2f2a5a04a2a0c114bb0a22e2a1a3cd3839d9d8fdd3f4a75e655",
        "darwin_amd64" => "01b18bdcbc2fd9d30c28c9e717315177e81470de6acad0f329699db6b4291fe0",
        "linux_arm64"  => "49e10e2d746dede79aad2aef62f9979a90279a7a427d663f78dea85530b95af7",
        "linux_amd64"  => "4b85c5129fecf118116d2a655c98245e4765af777668af4e483fd54c7befea25",
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
