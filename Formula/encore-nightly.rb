class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230513"
    checksums = {
        "darwin_arm64" => "9067b9c45ceb58d485005fd5bfb49b6d8aec521313e059373318e9fb83468c37",
        "darwin_amd64" => "169689789cb71062348a37b65ff72c4f6d7235089fda741840cb92e55f0a2d24",
        "linux_arm64"  => "94e1e8f3da83efd5b4b628c073449b82fba04f47670568206411bbd9dbd3fcbf",
        "linux_amd64"  => "adbd709b8ca93b37bdb5694ad2443430e0135778aa6f2d776b67edd499971df0",
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
